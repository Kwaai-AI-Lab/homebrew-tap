class Kwaainet < Formula
  desc "kwaainet – KwaaiNet node CLI"
  homepage "https://kwaai.ai"
  version "0.4.126"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.126/kwaainet-aarch64-apple-darwin.tar.xz"
      sha256 "3ec1033e3bb88b1bca7bf8d5323b7a42fb01e1acacae7e23926980801b4ec3eb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.126/kwaainet-x86_64-apple-darwin.tar.xz"
      sha256 "f5279ee0bcff00a1e9ce7269f896d274f38505b13b22e0eb41751593a61ee04b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.126/kwaainet-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1c90b26ee96ed5822f4b531ef191885c24223aaf471460c243600543f3f5a0b7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.126/kwaainet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8df85c10689a223b3b0790b7fee7ad9183bcb1c8a4324e765d857abe821ac2ff"
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
    bin.install "kwaainet" if OS.mac? && Hardware::CPU.arm?
    bin.install "kwaainet" if OS.mac? && Hardware::CPU.intel?
    bin.install "kwaainet" if OS.linux? && Hardware::CPU.arm?
    bin.install "kwaainet" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
