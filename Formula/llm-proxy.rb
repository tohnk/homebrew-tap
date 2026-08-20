class LlmProxy < Formula
  desc "SSE-resumable LLM API proxy"
  homepage "https://github.com/tohnk/llm-proxy"
  url "https://github.com/tohnk/llm-proxy/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "01615011cf6ef65e17b4a63f45d8c031a794a292edf18288b66e672ecda3c29f"
  license "MIT" # match whatever license llm-proxy actually uses
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "llm-proxy", shell_output("#{bin}/llm-proxy --help")
  end
end
