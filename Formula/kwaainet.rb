class Kwaainet < Formula
  desc "kwaainet – KwaaiNet node CLI"
  homepage "https://kwaai.ai"
  version "0.6.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.6.7/kwaainet-aarch64-apple-darwin.tar.xz"
      sha256 "70e57f3fb02ad1471a09c089b7a3f6a3add9ba3349b23351a1b5e7fb1c366bda"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.6.7/kwaainet-x86_64-apple-darwin.tar.xz"
      sha256 "6cbdf150dc6155f9d336cffe01db2661be658b60418aee3cbe0dc7ee2920139f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.6.7/kwaainet-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8b5ba1d331cb2626d3497a7feedd0e5897282ffdc76cc8b6f76baa7b739b9748"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.6.7/kwaainet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ab53578047b74913f787a2c57991df7fe95968486c05984d3449b40ea161ab82"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "kwaainet"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "kwaainet"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "kwaainet"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "kwaainet"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
