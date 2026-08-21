class Kwaainet < Formula
  desc "kwaainet – KwaaiNet node CLI"
  homepage "https://kwaai.ai"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.6.1/kwaainet-aarch64-apple-darwin.tar.xz"
      sha256 "ba395e755d85f0f24aac5637b9080f982855973db3fcb969665a2e6a2226a289"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.6.1/kwaainet-x86_64-apple-darwin.tar.xz"
      sha256 "5fc83122243f359ccf08c45c9402c56de36a6d8685e3e83e5ccd25b852910a6b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.6.1/kwaainet-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b815f89b3707396077a81151c315d97566d78908065c224f4f6db78c1c0d3eef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.6.1/kwaainet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9ec67186867555fbf3686508285fb69006436ef40876b70d4a30753242ffa69b"
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
