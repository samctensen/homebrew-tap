class Cusco < Formula
  desc "Tells any program which of your local coding agents needs you"
  homepage "https://github.com/samctensen/cusco"
  url "https://github.com/samctensen/cusco/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "c2691d40033e798535af847917b55af066d508d901b0dec7c8cb4f406d33e225"
  license "MIT"
  head "https://github.com/samctensen/cusco.git", branch: "main"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      Connect your coding agents to Cusco:
        cusco setup
      In Codex, run /hooks and trust the new hooks.
      In Grok Build, trust the folders you work in.
    EOS
  end

  service do
    run [opt_bin/"cusco", "serve"]
    keep_alive true
    log_path var/"log/cusco.log"
    error_log_path var/"log/cusco.log"
  end

  test do
    assert_match "cusco #{version}", shell_output("#{bin}/cusco --version")
    ENV["CUSCO_DIR"] = (testpath/"cusco").to_s
    assert_match "cusco is not running", shell_output("#{bin}/cusco status 2>&1", 1)
  end
end
