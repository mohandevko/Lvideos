Rails.application.config.middleware.use OmniAuth::Builder do |config|
  config.provider :facebook, '586318088100680', 'a300730d17e5ed7dfed5cec7c7665ccb'
  config.provider :twitter, 'qqAg2XN1QfkIyjtwNgROQ', 'Ja8SHgdVwJuFBKsJWYbZHsltGZH1sH39eGAZgEgZz4'
end

OmniAuth.config.on_failure = Proc.new do |env| new_path = "/"
  [302, {'Location' => new_path, 'Content-Type'=> 'text/html'}, []]
end