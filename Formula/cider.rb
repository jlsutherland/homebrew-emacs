require File.expand_path("../../Homebrew/emacs_formula", __FILE__)

class Cider < EmacsFormula
  desc "Clojure IDE for Emacs"
  homepage "https://github.com/clojure-emacs/cider"
  url "https://github.com/clojure-emacs/cider/archive/v0.15.0.tar.gz"
  sha256 "22381d3b3522c0b897f62d35592420c2e7843dd319a32a72eeb622483593f848"
  head "https://github.com/clojure-emacs/cider.git"

  depends_on EmacsRequirement => "24.4"
  depends_on "openjdk"

  depends_on "jlsutherland/homebrew-emacs/clojure-mode"
  depends_on "jlsutherland/homebrew-emacs/dash-emacs"
  depends_on "jlsutherland/homebrew-emacs/pkg-info"
  depends_on "jlsutherland/homebrew-emacs/queue-emacs"
  depends_on "jlsutherland/homebrew-emacs/seq" if Emacs.version < Version.create("25")
  depends_on "jlsutherland/homebrew-emacs/spinner-emacs"

  def install
    byte_compile Dir["*.el"]
    elisp.install Dir["*.el"], Dir["*.elc"]
  end

  test do
    (testpath/"test.el").write <<~EOS
      (add-to-list 'load-path "#{elisp}")
      (add-to-list 'load-path "#{Formula["jlsutherland/homebrew-emacs/clojure-mode"].opt_elisp}")
      (add-to-list 'load-path "#{Formula["jlsutherland/homebrew-emacs/dash-emacs"].opt_elisp}")
      (add-to-list 'load-path "#{Formula["jlsutherland/homebrew-emacs/pkg-info"].opt_elisp}")
      (add-to-list 'load-path "#{Formula["jlsutherland/homebrew-emacs/queue-emacs"].opt_elisp}")
      (add-to-list 'load-path "#{Formula["jlsutherland/homebrew-emacs/seq"].opt_elisp}")
      (add-to-list 'load-path "#{Formula["jlsutherland/homebrew-emacs/spinner-emacs"].opt_elisp}")
      (load "cider")
      (print cider-version)
    EOS
    assert_equal "\"#{version}\"", shell_output("emacs -Q --batch -l #{testpath}/test.el").strip
  end
end
