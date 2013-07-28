;; Time-stamp: <2013-07-28 20:33:47 leo>
;; AUTHOR: Leo "picarresursix" Perrin, <leoperrin@picarresursix.fr>
;; 
;; Functions to help me work with symmetric crypto.



(defun pi2-6/crypto/hamming-weight(hex)
  "Returns the hamming weight of the hexadecimel string <hex>."
  (let (result i c)
    (setq result 0)
    (dotimes (i (length hex))
      (setq c (char-to-string (aref hex i)))
      (cond ((or ; hw = 1
              (string= c "1")
              (string= c "2")
              (string= c "4")
              (string= c "8"))
             (setq result (+ result 1)))
            ((or ; hw = 2
              (string= c "3")
              (string= c "5")
              (string= c "6")
              (string= c "9")
              (string= c "a")
              (string= c "A")
              (string= c "c")
              (string= c "C"))
             (setq result (+ result 2)))
            ((or ; hw = 3
              (string= c "7")
              (string= c "b")
              (string= c "B")
              (string= c "D")
              (string= c "D")
              (string= c "e")
              (string= c "E"))
             (setq result (+ result 3)))
            ((or ; hw = 4
              (string= c "f")
              (string= c "F"))
             (setq result (+ result 4)))
            ))
    result))


(defun pi2-6/crypto/print-hamming-weight()
  "Prints the hamming weight of the highlighted string in the
  mini-buffer."
  (interactive)
  (if mark-active
      (let (hex)
          (setq hex (buffer-substring-no-properties
                     (region-beginning)
                     (region-end)))
        (if (= (length hex) 0)
            (message "0 (empty string)")
          (message (number-to-string (pi2-6/crypto/hamming-weight hex)))))))


