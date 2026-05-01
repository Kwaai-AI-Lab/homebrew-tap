class Kwaainet < Formula
  desc "kwaainet – KwaaiNet node CLI"
  homepage "https://kwaai.ai"
  version "0.4.12"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.12/kwaainet-aarch64-apple-darwin.tar.xz"
      sha256 "548b1ce6a0a0a8f5992bb5f87601379fce4b90abcb9226ef9389553616bf9e2b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.12/kwaainet-x86_64-apple-darwin.tar.xz"
      sha256 "ee1e887d40a7b489ef19789353da635c7137e465357727dceb703b4ca162b437"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.12/kwaainet-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bc3a5046fbccdd3a3369d7d070d98ae4e305ed4aa9a63117f7d1afa40b458d10"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.12/kwaainet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "24be1b2e878951b81ed35691470566c4318605a4719ecbc0cb0ee0158b8ea515"
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
