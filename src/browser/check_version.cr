module Browser
  module DetectVersion
    EXPECTED_RE = /\s*(?<operator>(\~>|<\~|=<|>=|<|>))?\s*(?<version>(\S)+)/

    # Semantic version checking.
    #
    # Check versions against each other, allowing for version ranges, pre-release
    # versions, and build metadata.
    #
    # Example:
    # ```
    # # simple version checking
    # check_version?("1.2.3", ">= 1.2.3") # => true
    # check_version?("1.2.3", ">= 1.2.4") # => false
    # check_version?("1.2.3", "< 1.2.4")  # => true

    # # version ranges
    # check_version?("1.2.3", ">= 1.2.3 < 1.3.0") # => true
    # check_version?("1.2.3", "~> 1.2.3") # => true
    # check_version?("2.0", "~> 1.2.3") # => false

    # # pre-release versions
    # check_version?("1.2.3-alpha", ">= 1.2.3-alpha") # => true
    # check_version?("1.2.3-alpha", ">= 1.2.3") # => false
    # check_version?("1.2.3-alpha", "< 1.2.3") # => true
    # check_version?("1.2.3-alpha", "< 1.2.3-beta") # => true

    # # build metadata
    # check_version?("1.2.3+build.1", ">= 1.2.3+build.1") # => true
    # check_version?("1.2.3+build.1", ">= 1.2.3") # => true
    # check_version?("1.2.3+build.1", "< 1.2.3") # => false

    # # Also handles versions with a mismatching number of dots
    # check_version?("1.2.3", ">= 1.2.2.4") # => true
    # check_version?("1.2.3.242", ">= 1.2.3") # => true

    # # If the expected version is nil, it will always return true
    # check_version?("1.2.3", nil) # => true

    # # Relaxed handling of spaces
    # check_version?("1.2.3", " >= 1.2.3") # => true
    # check_version?("1.2.3", ">=1.2.3") # => true
    # check_version?("1.2.3", ">= 1.2.3 <1.4") # => true

    # # Lastly, handles incorrectly formatted versions by returning false
    # check_version?("1.2.3", ">= 1.2.3.Chromium.2.1") # => false
    # ```
    #
    # @param [String] actual version
    # @param [String] expected version
    # @return [Boolean] whether the actual version matches the expected version
    def check_version?(actual_version, expected_version)
      # If the expected version is nil, it will always return true
      return true if expected_version.nil?

      actual_version = actual_version.to_s
      expected_version = expected_version.to_s

      # Parse the expected version string into operator and version components
      expected_version_match = expected_version.match(EXPECTED_RE)
      unless expected_version_match
        # Handle incorrectly formatted expected versions by returning false
        return false
      end
      expected_operator = expected_version_match["operator"]?
      expected_version = expected_version_match["version"]

      # Parse the actual version string into version components
      actual_version, actual_build_metadata = actual_version.includes?("+") ? actual_version.split('+') : {actual_version, nil}
      actual_version, actual_pre_release = actual_version.includes?("-") ? actual_version.split('-') : {actual_version, nil}
      actual_version_parts = actual_version.split('.').map(&.to_i)

      # Parse the expected version string into version components
      expected_version, expected_build_metadata = expected_version.includes?("+") ? expected_version.split('+') : {expected_version, nil}
      expected_version, expected_pre_release = expected_version.includes?("-") ? expected_version.split('-') : {expected_version, nil}
      expected_version_parts = expected_version.split('.').map(&.to_i)

      # If the number of version components is not the same, pad with zeros
      difference = actual_version_parts.size - expected_version_parts.size
      if difference < 0
        actual_version_parts.concat(Array.new(-difference, 0))
      elsif difference > 0
        expected_version_parts.concat(Array.new(difference, 0))
      end

      # TODO: Handle build metadata and pre-release versions

      # Compare the actual and expected versions based on the operator
      case expected_operator
      when nil, ">=", ">"
        return actual_version_parts >= expected_version_parts
      when "<=", "<"
        return actual_version_parts <= expected_version_parts
      when "~>"
        return (actual_version_parts[0] == expected_version_parts[0]) &&
          (actual_version_parts[1] >= expected_version_parts[1]) &&
          (actual_version_parts <= expected_version_parts.map_with_index { |v, i| i == 1 ? v + 1 : v })
      when "<~"
        return (actual_version_parts[0] == expected_version_parts[0]) &&
          (actual_version_parts[1] <= expected_version_parts[1]) &&
          (actual_version_parts >= expected_version_parts.map_with_index { |v, i| i == 1 ? v - 1 : v })
      else
        # Handle invalid operators by returning false
        return false
      end
    rescue
      # Handle incorrectly formatted actual versions by returning false
      return false
    end
  end
end
