;; extends

((attribute
    (attribute_name) @att_name (#eq? @att_name "class")
    (quoted_attribute_value (attribute_value) @conceal) (#set! @conceal conceal "…")))
