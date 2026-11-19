class Cusco < Formula
  desc "Tells any program which of your local coding agents needs you"
  homepage "https://github.com/samctensen/cusco"
  url "https://github.com/samctensen/cusco/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "7d51b07324f6b5a24ed1b33465b44bb6fea7feb448cd99e64cdc9ee2a171b822"
  license "MIT"
  head "https://github.com/samctensen/cusco.git", branch: "main"

  # Bottled by this tap's CI, so only --build-from-source and --HEAD need rust.
  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      Start Cusco now, and at every login:
        cusco start
        cusco autostart on
      Connect your coding agents to Cusco:
        cusco setup
      In Codex, run /hooks and trust the new hooks.
      In Grok Build, trust the folders you work in.
    EOS
  end

  test do
    assert_match "cusco #{version}", shell_output("#{bin}/cusco --version")
    ENV["CUSCO_DIR"] = (testpath/"cusco").to_s
    assert_match "cusco is not running", shell_output("#{bin}/cusco status 2>&1", 1)
  end
end
