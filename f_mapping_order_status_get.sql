CREATE OR REPLACE FUNCTION public.f_mapping_order_status_get(
    in_courier_code varchar,
    in_status_delivery_code varchar,
    in_company_group varchar DEFAULT 'HSE'
)
RETURNS TABLE (
    status_code varchar,
    status_delivery_code varchar,
    status_desc varchar,
    courier_code varchar
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        smos.status_code,
        smos.status_delivery_code,
        mos.status_desc,
        smos.courier_code
    FROM public.s_mapping_order_status smos
    LEFT JOIN public.m_order_status mos
           ON mos.status_code = smos.status_code
    WHERE LOWER(smos.courier_code) = LOWER(in_courier_code)
      AND LOWER(smos.status_delivery_code) = LOWER(in_status_delivery_code)
      AND UPPER(COALESCE(smos.company_group, in_company_group)) = UPPER(in_company_group)
    ORDER BY smos.modified_on DESC NULLS LAST,
             smos.created_on DESC NULLS LAST
    LIMIT 1;
END;
$$ LANGUAGE plpgsql STABLE;
