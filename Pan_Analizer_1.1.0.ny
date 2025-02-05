;nyquist plug-in
;version 4
;type analyze
;name "Pan Analizer"
;copyright "Released under terms of the GNU General Public License version 2 or later"

;control Min "Cutoff filter" int "(Min)" -100 -100 0
;control Max "Cutoff filter" int "(Max)" 100 0 100

(defun calculate-weighted-mean (sound min max)
  (let ((sum 0)
        (weight-sum 0)
        (weight 1)
        (value (snd-fetch sound)))
    (while value
      (when (and (>= value min) (<= value max))
        (setq sum (+ sum (* value weight)))
        (setq weight-sum (+ weight-sum weight))
        (setq weight (1+ weight)))
      (setq value (snd-fetch sound)))
    (if (> weight-sum 0)
        (/ sum weight-sum)
        0)))

(defun find-pan-center (track min max)
  (let* ((left (snd-copy (aref track 0)))
         (right (snd-copy (aref track 1)))
         (left-weighted-mean (calculate-weighted-mean left min max))
         (right-weighted-mean (calculate-weighted-mean right min max))
         (total-weighted-mean (+ (abs left-weighted-mean) (abs right-weighted-mean)))
         (pan-center (if (> total-weighted-mean 0)
                         (/ (- right-weighted-mean left-weighted-mean) total-weighted-mean)
                         0)))
    (let ((pan-value (round (* pan-center 100))))
      (- pan-value))))

(find-pan-center *track* Min Max)
