D = Steep::Diagnostic

target :lib do
  signature "sig"

  check "lib"

  library "csv"
  library "forwardable"
  library "net-http"
  library "openssl"
  library "stringio"
  library "uri"
  library "zlib"
  library "date"
  library "time"
  library "json"

  configure_code_diagnostics(D::Ruby.strict) do |hash|
    # Empty collections in fetch defaults are type-safe due to the caller context
    hash[D::Ruby::UnannotatedEmptyCollection] = nil
  end
end
