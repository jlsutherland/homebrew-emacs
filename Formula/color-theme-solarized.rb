class ColorThemeSolarized < Formula
  desc "Ethan Schoonover's Solarized color scheme"
  homepage "https://github.com/sellout/emacs-color-theme-solarized"
  head "https://github.com/sellout/emacs-color-theme-solarized.git"

  def install
    (share/"emacs/site-lisp/solarized").install Dir["*.el"]
    doc.install "README.md"
  end

  def caveats; <<-EOS.undent
    Add the following lines to your init file:

      (add-to-list 'custom-theme-load-path "#{HOMEBREW_PREFIX}/share/emacs/site-lisp/solarized")
      (load-theme 'solarized t)
      (setq solarized-termcolors 256)
    EOS
  end

  test do
    (testpath/"test.el").write <<-EOS.undent
      (add-to-list 'custom-theme-load-path "#{share}/emacs/site-lisp/solarized")
      (load-theme 'solarized t)
      (setq solarized-termcolors 256)
      (add-to-list 'default-frame-alist '(background-mode . dark))
      (print (minibuffer-prompt-width))
    EOS
    assert_equal "0", shell_output("emacs -batch -l #{testpath}/test.el").strip  end
end
