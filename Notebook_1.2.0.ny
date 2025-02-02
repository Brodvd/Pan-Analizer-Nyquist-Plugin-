;nyquist plug-in
;version 4
;type analyze
;name "Pan Analizer"
;copyright "Released under terms of the GNU General Public License version 2 or later"

(defun calculate-weighted-mean (sound)
  (let ((sum 0)
        (weight-sum 0)
        (weight 1)
        (value (snd-fetch sound)))
    (while value
        (setq sum (+ sum (* value weight)))
        (setq weight-sum (+ weight-sum weight))
        (setq weight (1+ weight)))
      (setq value (snd-fetch sound)))
    (if (> weight-sum 0)
        (/ sum weight-sum)
        0)))

(defun find-pan-center (track)
  (let* ((left (snd-copy (aref track 0)))
         (right (snd-copy (aref track 1)))
         (left-weighted-mean (calculate-weighted-mean left))
         (right-weighted-mean (calculate-weighted-mean right))
         (total-weighted-mean (+ (abs left-weighted-mean) (abs right-weighted-mean)))
         (pan-center (if (> total-weighted-mean 0)
                         (/ (- right-weighted-mean left-weighted-mean) total-weighted-mean)
                         0)))
    (let ((pan-value (round (* pan-center 100))))
      (- pan-value))))

(find-pan-center *track*)
