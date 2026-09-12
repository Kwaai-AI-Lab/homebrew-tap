class Kwaainet < Formula
  desc "kwaainet – KwaaiNet node CLI"
  homepage "https://kwaai.ai"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.7.0/kwaainet-aarch64-apple-darwin.tar.xz"
      sha256 "15749c947de572af18d550e84f3291f9d7f4e101cbb55fa4bbed2874c7b6b972"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.7.0/kwaainet-x86_64-apple-darwin.tar.xz"
      sha256 "19c06a5cfd9752a39fa00cd60a25f197e2ca0a2fc96e884a4c2032f3b3bb6994"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.7.0/kwaainet-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2d4d679bbf6fda67cf4b9ae403cfbf26ecd9590aaa4dd5d8551d0dd1ef55787a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.7.0/kwaainet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b0828974674a8954f690b5aa490de3ced659f6ff2aabe75622272bdfd1f2003e"
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
