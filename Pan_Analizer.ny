;nyquist plug-in
;version 4
;type analyze
;name "Pan Analizer"

(defun calculate-median-incremental (sound)
  (let ((values '())
        (value (snd-fetch sound)))
    (while value
      (setq values (cons value values))
      (setq value (snd-fetch sound)))
    (if values
        (let* ((sorted (sort values #'<))
               (len (length sorted))
               (middle (/ len 2)))
          (if (evenp len)
              (/ (+ (nth middle sorted) (nth (1- middle) sorted)) 2)
              (nth middle sorted)))
        0)))

(defun find-pan-center (track)
  (let* ((left (snd-copy (aref track 0)))
         (right (snd-copy (aref track 1)))
         (left-median (calculate-median-incremental left))
         (right-median (calculate-median-incremental right))
         (total-median (+ (abs left-median) (abs right-median)))
         (pan-center (if (> total-median 0)
                         (/ (- right-median left-median) total-median)
                         0)))
    (round (* pan-center 100))))

(find-pan-center *track*)
