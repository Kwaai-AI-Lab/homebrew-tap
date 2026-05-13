class Kwaainet < Formula
  desc "kwaainet – KwaaiNet node CLI"
  homepage "https://kwaai.ai"
  version "0.4.56"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.56/kwaainet-aarch64-apple-darwin.tar.xz"
      sha256 "719eeab9c5f8645f3840335c3f6a99e19eab0f8cbc26818bdd6537b48d920eda"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.56/kwaainet-x86_64-apple-darwin.tar.xz"
      sha256 "098c80353125ce7dda31f465e8ec95f72d98ba658f49f38508f49524a2dcb46d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.56/kwaainet-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e949b316aafaf59ec166b2ea463ca0db73c8ee0da8013f036fd669bc0da1821d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.4.56/kwaainet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c26b0ac2df8118eb677a737367cb2d98a2531cd701068f4021b3f128a1b04290"
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
