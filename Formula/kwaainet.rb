class Kwaainet < Formula
  desc "kwaainet – KwaaiNet node CLI"
  homepage "https://kwaai.ai"
  version "0.6.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.6.5/kwaainet-aarch64-apple-darwin.tar.xz"
      sha256 "96cfa11225f51d700292aa7e134443b5df44a804b9fd15453c888f04d091c073"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.6.5/kwaainet-x86_64-apple-darwin.tar.xz"
      sha256 "ea4ce644037795f4d7c0cb2d1c7774d81a80b55580d3015e8254e851d6671cf8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.6.5/kwaainet-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ca1c0c8a364bb62a9a24d6c88f6515b6b71f3617f7400fb66c071b707ca15dda"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kwaai-AI-Lab/KwaaiNet/releases/download/v0.6.5/kwaainet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ad020fec732d00799146e490f464d2e484157726ec6e745cec6751570db16703"
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
