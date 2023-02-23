module Browser
  @@user_agents : Hash(String, String)?

  def self.user_agents
    @@user_agents ||= browser_user_agents
      .merge(bot_user_agents)
      .merge(search_engine_user_agents)
  end

  @@browser_user_agents : Hash(String, String)?

  def self.browser_user_agents
    @@browser_user_agents ||= YAML.parse({{ read_file "spec/fixtures/ua.yml" }}).as_h
      .transform_keys(&.as_s)
      .transform_values(&.as_s)
  end

  @@bot_user_agents : Hash(String, String)?

  def self.bot_user_agents
    @@bot_user_agents ||= YAML.parse({{ read_file "spec/fixtures/ua_bots.yml" }}).as_h
      .transform_keys(&.as_s)
      .transform_values(&.as_s)
  end

  @@search_engine_user_agents : Hash(String, String)?

  def self.search_engine_user_agents
    @@search_engine_user_agents ||= begin
      YAML.parse({{ read_file "spec/fixtures/ua_search_engines.yml" }}).as_h
        .transform_keys(&.as_s)
        .transform_values(&.as_s)
    end
  end

  def self.[](key)
    user_agents[key]
  end
end
