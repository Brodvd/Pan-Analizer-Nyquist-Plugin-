;nyquist plug-in
;version 4
;type analyze
;name "Pan Analizer"
;copyright "Released under terms of the GNU General Public License version 2 or later"

(defun calculate-pan-per-sample (left right)
  (let ((denominator (+ left right)))
    (if (/= denominator 0)
        (/ (- right left) denominator)
        0)))

(defun calculate-weighted-mean-pan (track)
  (let* ((left (snd-copy (aref track 0)))
         (right (snd-copy (aref track 1)))
         (sum 0)
         (weight-sum 0)
         (weight 1)
         (left-sample (snd-fetch left))
         (right-sample (snd-fetch right)))
    (while (and left-sample right-sample)
      (let ((pan (calculate-pan-per-sample left-sample right-sample)))
        (setq sum (+ sum (* pan weight)))
        (setq weight-sum (+ weight-sum weight))
        (setq weight (1+ weight)))
      (setq left-sample (snd-fetch left))
      (setq right-sample (snd-fetch right)))
    (let ((weighted-mean-pan (if (> weight-sum 0)
                                 (/ sum weight-sum)
                                 0)))
      weighted-mean-pan)))

(defun find-pan-center (track)
  (let ((weighted-mean-pan (calculate-weighted-mean-pan track)))
    (let ((pan-value (round (* weighted-mean-pan 100))))
      pan-value))) ; Removed negation here

(find-pan-center *track*)
