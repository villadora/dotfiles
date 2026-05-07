;; -*- mode: dotspacemacs -*-
;; vim:ft=elisp

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very very startup of Spacemacs initialization
before layers configuration."
  (setq dotspacemacs-elpa-archives
        '(("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
          ("org"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
          ("gnu"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/"))))

;; Dotfile user-config
(defun dotspacemacs/user-config ()
  "User configuration. Execute with `SPC f e R`."
  )