;nyquist plug-in
;version 4
;type analyze
;name "Pan Analyzer"
;debugging "true"
;copyright "Released under terms of the GNU General Public License version 2 or later"

(defun calculate-pan-per-sample (left right)  ; <--- Definizione di calculate-pan-per-sample *PRIMA*
  (let ((denominator (+ left right)))
    (if (/= denominator 0)
        (/ (- right left) denominator)
        0)))

(defun calculate-weighted-mean-pan (track)
  (let* ((left (snd-copy (aref track 0)))
         (right (snd-copy (aref track 1)))
         (sum 0.0)
         (weight-sum 0.0)
         (weight 1.0)
         (left-sample (snd-fetch left))
         (right-sample (snd-fetch right)))
    (while (and left-sample right-sample)
      (progn
        (let ((pan (calculate-pan-per-sample left-sample right-sample))) ; <--- Chiamata a calculate-pan-per-sample
          (when (and (numberp pan) (numberp left-sample) (numberp right-sample)
                     (/= left 0) (/= right 0))
            (setq sum (+ sum (* pan weight)))
            (setq weight-sum (+ weight-sum weight))))
        (setq weight (* weight 1.1))
        (setq left-sample (snd-fetch left))
        (setq right-sample (snd-fetch right))))
    (let ((weighted-mean-pan (if (> weight-sum 0)
                                 (/ sum weight-sum)
                                 0)))
      weighted-mean-pan)))

(defun find-pan-center (track)
  (let ((mean-pan (calculate-weighted-mean-pan track)))
    (let ((pan-value (round (* mean-pan 100))))
      pan-value)))

(find-pan-center *track*)
