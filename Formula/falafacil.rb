# typed: false
# frozen_string_literal: true

require "json"

class Falafacil < Formula
  desc "Transcrição de voz em português com Gemini"
  homepage "https://github.com/OthonBreener/falafacil"
  url "https://github.com/OthonBreener/falafacil/releases/download/v0.2.1/falafacil-0.2.1-linux-x86_64.tar.gz"
  sha256 "73fe790f39bfcfa53e9ba067b8dfe5e02dcb17b41a319a1b0814075b32473f82"

  depends_on arch: :x86_64
  depends_on :linux

  def install
    libexec.install "falafacil"
    bin.install_symlink libexec/"falafacil"

    marker_payload = {
      schema:          1,
      channel:         "homebrew",
      formula:         "OthonBreener/falafacil/falafacil",
      version:         version.to_s,
      homebrew_prefix: HOMEBREW_PREFIX.to_s,
      brew_path:       (HOMEBREW_PREFIX/"bin/brew").to_s,
      launch_path:     (opt_bin/"falafacil").to_s,
      marker_path:     (opt_prefix/"libexec/falafacil-homebrew.json").to_s,
    }
    (libexec/"falafacil-homebrew.json").write JSON.generate(marker_payload)
  end

  def caveats
    <<~EOS
      Execute falafacil uma vez após a instalação para registrá-lo no menu de aplicativos.
    EOS
  end

  test do
    system "#{bin}/falafacil", "--update-probe", version.to_s
  end
end
