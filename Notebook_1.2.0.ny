(defun clip-values (values min max)
  (mapcar (lambda (x) (max min (min x max))) values))

(defun truncated-mean (values percentage)
  (let* ((sorted-values (sort values #'<))
         (n (length values))
         (k (round (* n percentage))))
    (mean (subseq sorted-values k (- n k)))))

;; Esempio di utilizzo
(setq pan-values '(-100 -50 -30 -20 -10 0 10 20 30 50 100))
(setq percentage 0.05) ;; Escludi il 5% dei valori più bassi e più alti
(setq clipped-values (clip-values pan-values -90 90))
(truncated-mean clipped-values percentage)
