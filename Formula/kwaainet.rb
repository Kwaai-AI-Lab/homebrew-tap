class Kwaainet < Formula
  desc "kwaainet – KwaaiNet node CLI"
  homepage "https://kwaai.ai"
  version "0.4.27"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.27/kwaainet-aarch64-apple-darwin.tar.xz"
      sha256 "d81aae2710cfb47d507f78c9121ed558a5c904a0283908cc172c314ab4bf1a62"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.27/kwaainet-x86_64-apple-darwin.tar.xz"
      sha256 "eadd0c9ed221dcfc8a4b5344d092f59ff56a4c40ed70604972991c334470af73"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.27/kwaainet-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dc5ec77c3c0dc3444e538bf6cd0bddf5830debabd66ba2867789db6fa28af2b2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.27/kwaainet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8b31a433330124bdd68329a281510d7625a59575493f407006b262a4ab95c008"
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
