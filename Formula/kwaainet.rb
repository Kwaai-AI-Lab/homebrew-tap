class Kwaainet < Formula
  desc "kwaainet – KwaaiNet node CLI"
  homepage "https://kwaai.ai"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.6.0/kwaainet-aarch64-apple-darwin.tar.xz"
      sha256 "b43b470c7ec6547276abb4118ca703515563a27f24697aa462266d89621f5f72"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.6.0/kwaainet-x86_64-apple-darwin.tar.xz"
      sha256 "354bbc41b08d8bc95781f2bf4d4fa70d45c1976909424b83f05cae15e1af3adf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.6.0/kwaainet-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d3fdda689f820020cf3f3cca414669e22fe5e74322bea6c4a6c13f58cc764183"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.6.0/kwaainet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "26ec4c97d0dd9d586a889cb396bc23838e9cb4a190b0e40d951a349b465911e0"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

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
