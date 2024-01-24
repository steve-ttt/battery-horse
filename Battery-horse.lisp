;; for SBCL compile with 
;; (sb-ext:save-lisp-and-die "Battery-horse.X64.linux.bin" :executable t :toplevel 'main)

;; "/usr/share/dict/words"
(ql:quickload 'uiop) ;; for (uiop:command-line-arguments )

(setf *random-state* (make-random-state t)) ;; initialise the random state seed 

(defvar *dictionary*  "/usr/share/dict/words")

(defun words-filter-size (in-file min max)
  "return a list of words that are greater than 3 and less than 8 from the file"
  (let ((words '())
	(flist (uiop:read-file-lines in-file)))
    (dolist (i flist)
      (when (and (> (length i) min) (< (length i) max))
       (setf words (CONS i words))))
   words))

(defun generate (min-word-count max-word-count &optional (dictionary "/usr/share/dict/words"))
  "generartes a random password in the correct-battery-horse-staple style"
  (let ((len (length  (words-filter-size dictionary min-word-count  max-word-count)))
	(wdList (words-filter-size dictionary min-word-count max-word-count)))
    (format t "~%~A-~A-~A-~A"  (nth (random len) wdList)
	    (nth (random len) wdList) (nth (random len) wdList)
	    (nth (random len) wdList))))

(defun gen-n (&optional (n 10) (min-word-count 4) (max-word-count 8) (dictionary "/usr/share/dict/words") )
  "generate N number of passwords"
  (dotimes (x n)
    (generate min-word-count max-word-count dictionary) ))

(defun main ()
  "Main function to parse command-line arguments and generate passwords.
  
  Command-line arguments should be in the form of key-value pairs:
  -n <n> -min <min-word-count> -max <max-word-count> [-dictionary <dictionary>]
  
  The function will generate <n> passwords, each composed of words with a length
  between <min-word-count> and <max-word-count>. If provided, it will use the
  words from the file at <dictionary>."
  (setf *random-state* (make-random-state t))  ;; generate a new random-state seed this needs to be in the main function for the compiled version if just loading the lisp code it can be global 
  (let* ((args (uiop:command-line-arguments))
         (arg-hash (make-hash-table :test 'equal)))
    (loop for (key value) on args by #'cddr do
      (setf (gethash (string-right-trim (list #\:) key) arg-hash) value))
    (let ((n (and (gethash "-n" arg-hash) (parse-integer (gethash "-n" arg-hash))))
          (min-word-count (and (gethash "-min" arg-hash) (parse-integer (gethash "-min" arg-hash))))
          (max-word-count (and (gethash "-max" arg-hash) (parse-integer (gethash "-max" arg-hash))))
          (dictionary (gethash "-dictionary" arg-hash)))
      (if (and n min-word-count max-word-count)
          (if dictionary
              (gen-n n min-word-count max-word-count dictionary)
              (gen-n n min-word-count max-word-count))
          (format t "Invalid arguments. Expected: -n <number to generate> -min <min-word-count> -max <max-word-count> [-dictionary </path/to/dictionary>]. ~%Got: ~A" args)))
    (format t "~%~%")
    (exit)))


