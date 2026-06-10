CREATE OR REPLACE FUNCTION public.f_delivery_tracking_insert(
    in_invoice_id varchar,
    in_status_delivery_code varchar,
    in_status_desc varchar,
    in_company_group varchar DEFAULT 'HSE'
)
RETURNS void AS $$
BEGIN
    INSERT INTO public.t_delivery_tracking (
        company_group,
        tracking_id,
        invoice_id,
        status_on,
        status_delivery_code,
        status_desc,
        created_on
    ) VALUES (
        in_company_group,
        lpad(nextval('public.t_delivery_tracking_tracking_id_seq')::text, 10, '0'),
        in_invoice_id,
        now(),
        in_status_delivery_code,
        in_status_desc,
        now()
    );
END;
$$ LANGUAGE plpgsql;
