D = Steep::Diagnostic

target :lib do
  signature "sig"

  check "lib"

  library "forwardable"
  library "net-http"
  library "openssl"
  library "stringio"
  library "uri"
  library "zlib"
  library "date"
  library "time"
  library "json"

  configure_code_diagnostics(D::Ruby.strict)
end
