# typed: false
# frozen_string_literal: true

require "json"

class Falafacil < Formula
  desc "Transcrição de voz em português com Gemini"
  homepage "https://github.com/OthonBreener/falafacil"
  url "https://github.com/OthonBreener/falafacil/releases/download/v0.4.0/falafacil-0.4.0-linux-x86_64.tar.gz"
  sha256 "1a3930446b06eb194f0edc1fd204ceb652afee2fcc0bc3c96aa445ecece44395"

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
