class Kwaainet < Formula
  desc "kwaainet – KwaaiNet node CLI"
  homepage "https://kwaai.ai"
  version "0.4.116"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.116/kwaainet-aarch64-apple-darwin.tar.xz"
      sha256 "1f65e620a6c71d1987c797f2340bb32ff83c5926d306e4d7934b88aa538f10fe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.116/kwaainet-x86_64-apple-darwin.tar.xz"
      sha256 "dc02d99562400c4e107042a385ca7afad8fcf678d6d01da6210d56c99c918359"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.116/kwaainet-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bbc4f45386ba7a05f0ebd5b0229b199b6710946322ba36136b42f32ba121bfc9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.116/kwaainet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d15366b888c8be8982750337560367e1b957f5386cc780f77ab900ec139f0ada"
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
