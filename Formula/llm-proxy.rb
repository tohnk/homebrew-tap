class LlmProxy < Formula
  desc "SSE-resumable LLM API proxy"
  homepage "https://github.com/tohnk/llm-proxy"
  url "https://github.com/tohnk/llm-proxy/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "0a998f991d53c3ad6b497a2fd8d52fa79bec58feea51db90ae6e21606720a478"
  license "MIT" # match whatever license llm-proxy actually uses
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "llm-proxy", shell_output("#{bin}/llm-proxy --help")
  end
end
