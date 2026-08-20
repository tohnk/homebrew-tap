class LlmProxy < Formula
  desc "SSE-resumable LLM API proxy"
  homepage "https://github.com/tohnk/llm-proxy"
  url "https://github.com/tohnk/llm-proxy/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "1900fd6cfd6a36be10bd1ca6c1cbe4e3173524f1efd2d09443cb105790c57e45"
  license "MIT" # match whatever license llm-proxy actually uses
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "llm-proxy", shell_output("#{bin}/llm-proxy --help")
  end
end
