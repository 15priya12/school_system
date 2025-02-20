Rails.application.config.content_security_policy do |policy|
    policy.default_src :self, "*"
    policy.connect_src :self, "*"
    policy.script_src :self, "*"
    policy.style_src :self, "*"
    policy.img_src :self, "*"
    policy.frame_src :self, "*"
  end
  