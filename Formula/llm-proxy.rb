class LlmProxy < Formula
  desc "SSE-resumable LLM API proxy"
  homepage "https://github.com/tohnk/llm-proxy"
  url "https://github.com/tohnk/llm-proxy/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "de165c714b5e6394119f5b49d2bf626ade1fe6fb6b7664ffff5b507a8504539b"
  license "MIT" # match whatever license llm-proxy actually uses
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "llm-proxy", shell_output("#{bin}/llm-proxy --help")
  end
end
