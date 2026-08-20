class LlmProxy < Formula
  desc "SSE-resumable LLM API proxy"
  homepage "https://github.com/tohnk/llm-proxy"
  url "https://github.com/tohnk/llm-proxy/archive/refs/tags/v0.0.0.tar.gz"
  sha256 "PLACEHOLDER_REPLACE_WITH_REAL_SHA256"
  license "MIT" # match whatever license llm-proxy actually uses
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "llm-proxy", shell_output("#{bin}/llm-proxy --help")
  end
end
