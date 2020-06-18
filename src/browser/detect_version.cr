require "semantic_compare"

module Browser
  module DetectVersion
    private def detect_version?(actual_version, expected_version)
      return true unless expected_version
      return false if expected_version && !actual_version

      fixed = fix_semantics(actual_version)
      actual_version = parse_version(fixed)

      if expected_version.includes?("||")
        SemanticCompare.complex_expression actual_version, expected_version.to_s
      else
        SemanticCompare.simple_expression actual_version, expected_version.to_s
      end
    end

    private def fix_semantics(version)
      parts = version.split('.')
      major, minor, build, patch = parts[0], parts[1]? || "0", parts[2]?, parts[3]?
      patch, build = build && patch ? {patch, build} : {build, nil}
      sem = [major, minor || "0", patch || "0"].join(".")
      build ? "#{sem}+#{build}" : sem
    end

    private def parse_version(version)
      SemanticVersion.parse(version.to_s)
    end
  end
end
