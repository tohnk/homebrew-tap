require "etc"

class Hypura < Formula
  desc "Storage-tier-aware LLM inference scheduler for Apple Silicon"
  homepage "https://github.com/t8/hypura"
  # Git downloads include the pinned llama.cpp submodule.
  url "https://github.com/t8/hypura.git",
      tag:      "v0.2.0",
      revision: "7fb2479a070842a0d304ccde0a9f229d151e7569"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "llvm" => :build
  depends_on :macos
  depends_on arch: :arm64

  # Intentionally reuse rustup, as in this tap's epubfix formula.
  # Do not add a Homebrew Rust dependency.
  def install
    real_home = Etc.getpwuid(Process.uid).dir
    cargo_bin = "#{real_home}/.cargo/bin"
    cargo = "#{cargo_bin}/cargo"
    rustc = "#{cargo_bin}/rustc"

    [cargo, rustc].each do |tool|
      odie "Expected rustup tool at #{tool}, but it is missing or not executable." unless File.executable?(tool)
    end

    ENV["RUSTUP_HOME"] = "#{real_home}/.rustup"
    ENV["CARGO_HOME"] = (buildpath/"cargo-home").to_s
    ENV.prepend_path "PATH", cargo_bin
    ENV["RUSTC"] = rustc

    # bindgen needs libclang to generate the llama.cpp bindings.
    ENV["LIBCLANG_PATH"] = Formula["llvm"].opt_lib.to_s
    ENV["CLANG_PATH"] = (Formula["llvm"].opt_bin/"clang").to_s

    # Backport upstream's macOS build fix, which followed v0.2.0.
    # Build the llama.cpp libraries without its standalone tools or OpenSSL.
    inreplace "hypura-sys/build.rs",
              '.define("LLAMA_BUILD_SERVER", "OFF")',
              [
                '.define("LLAMA_BUILD_SERVER", "OFF")',
                '.define("LLAMA_BUILD_TOOLS", "OFF")',
                '.define("LLAMA_BUILD_COMMON", "OFF")',
                '.define("LLAMA_OPENSSL", "OFF")',
                '.define("GGML_NATIVE", "OFF")',
              ].join("\n        ")

    system cargo, "--version"
    system rustc, "--version"
    system cargo, "install", *std_cargo_args
  end

  test do
    assert_match "hypura #{version}", shell_output("#{bin}/hypura --version")
    assert_match "Storage-tier-aware LLM inference scheduler", shell_output("#{bin}/hypura --help")
  end
end
