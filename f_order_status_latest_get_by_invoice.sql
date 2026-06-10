CREATE OR REPLACE FUNCTION public.f_order_status_latest_get_by_invoice(
    in_company_group varchar,
    in_invoice_id varchar
)
RETURNS TABLE (
    company_group varchar,
    group_order_id varchar,
    order_id varchar,
    status_code varchar,
    invoice_id varchar,
    awb_no varchar
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        d.company_group,
        d.group_order_id,
        d.order_id,
        d.status_code,
        d.invoice_id,
        d.awb_no
    FROM public.t_delivery_he d
    WHERE UPPER(d.company_group) = UPPER(in_company_group)
      AND d.invoice_id = in_invoice_id
    ORDER BY d.status_on DESC NULLS LAST,
             d.group_order_id DESC,
             d.order_id DESC
    LIMIT 1;
END;
$$ LANGUAGE plpgsql STABLE;
