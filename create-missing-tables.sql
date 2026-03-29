-- SQL script to create missing database tables
-- Execute this in your Supabase SQL editor

-- Create missing tables with proper structure
CREATE TABLE IF NOT EXISTS offer_pricing (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    content JSONB NOT NULL DEFAULT '{
        "title": "Get Your Nutritious Snack Box Today",
        "subtitle": "Limited time offer with fast delivery",
        "sale_price": 31.95,
        "cta_text": "Order Now on Walmart",
        "benefits": [
            "42 count variety pack",
            "Fast delivery included",
            "Premium packaging",
            "Satisfaction guaranteed"
        ],
        "trust_elements": [
            {"icon": "Shield", "text": "Secure checkout"},
            {"icon": "Truck", "text": "Fast delivery"},
            {"icon": "BadgeCheck", "text": "Quality guaranteed"}
        ]
    }'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS customer_reviews (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    content JSONB NOT NULL DEFAULT '{
        "title": "What Our Customers Say",
        "reviews": [
            {
                "name": "Sarah M.",
                "rating": 5,
                "comment": "Amazing variety and quality! My family loves these snacks.",
                "location": "Texas",
                "verified": true
            },
            {
                "name": "Michael R.",
                "rating": 5,
                "comment": "Perfect for office snacking. Great value for money.",
                "location": "California",
                "verified": true
            },
            {
                "name": "Emma L.",
                "rating": 4,
                "comment": "High quality snacks, fast delivery. Will order again!",
                "location": "Florida",
                "verified": true
            }
        ]
    }'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS footer (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    content JSONB NOT NULL DEFAULT '{
        "social_links": [
            {"name": "Facebook", "icon": "Facebook", "url": "https://facebook.com"},
            {"name": "Instagram", "icon": "Instagram", "url": "https://instagram.com"},
            {"name": "Twitter", "icon": "Twitter", "url": "https://twitter.com"}
        ]
    }'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS product_gallery (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    content JSONB NOT NULL DEFAULT '{
        "title": "Delicious Snack Variety",
        "images": [
            {
                "url": "https://cdn.builder.io/api/v1/image/assets%2F84282e2d620247d2b8d8845fda2c790e%2F79d471e5bc56457eb2c3b1c3eb6586ae?format=webp&width=800",
                "alt": "Nutritious Snack Box",
                "title": "Complete Snack Collection"
            },
            {
                "url": "https://cdn.builder.io/api/v1/image/assets%2F79b7dfd5cb0f4ca0b96e836c27c6ef40%2F4d9abe9f679440fcb3470285697707f4?format=webp&width=800",
                "alt": "Breakfast Bars",
                "title": "Healthy Breakfast Options"
            },
            {
                "url": "https://cdn.builder.io/api/v1/image/assets%2F79b7dfd5cb0f4ca0b96e836c27c6ef40%2F6305c43f8b6449fc8926c50b002e25fe?format=webp&width=800",
                "alt": "Premium Packaging",
                "title": "Professional Presentation"
            }
        ]
    }'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS trust_section (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    content JSONB NOT NULL DEFAULT '{
        "walmart_info": {
            "text": "Sold on Walmart",
            "subtext": "Trusted marketplace with secure checkout"
        },
        "seller_info": {
            "name": "Gift-A-Snack",
            "rating": 4.6,
            "reviews_count": 127
        },
        "guarantee": {
            "text": "30-Day Returns",
            "subtext": "Easy returns & exchanges"
        }
    }'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE offer_pricing ENABLE ROW LEVEL SECURITY;
ALTER TABLE customer_reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE footer ENABLE ROW LEVEL SECURITY;
ALTER TABLE product_gallery ENABLE ROW LEVEL SECURITY;
ALTER TABLE trust_section ENABLE ROW LEVEL SECURITY;

-- Create policies for public read access
CREATE POLICY "Enable read access for all users" ON offer_pricing FOR SELECT USING (true);
CREATE POLICY "Enable read access for all users" ON customer_reviews FOR SELECT USING (true);
CREATE POLICY "Enable read access for all users" ON footer FOR SELECT USING (true);
CREATE POLICY "Enable read access for all users" ON product_gallery FOR SELECT USING (true);
CREATE POLICY "Enable read access for all users" ON trust_section FOR SELECT USING (true);

-- Create policies for authenticated write access (for admin)
CREATE POLICY "Enable write access for authenticated users" ON offer_pricing FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Enable write access for authenticated users" ON customer_reviews FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Enable write access for authenticated users" ON footer FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Enable write access for authenticated users" ON product_gallery FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Enable write access for authenticated users" ON trust_section FOR ALL USING (auth.role() = 'authenticated');

-- Insert default data
INSERT INTO offer_pricing (content) VALUES ('{
    "title": "Get Your Nutritious Snack Box Today",
    "subtitle": "Limited time offer with fast delivery",
    "sale_price": 31.95,
    "cta_text": "Order Now on Walmart",
    "benefits": [
        "42 count variety pack",
        "Fast delivery included", 
        "Premium packaging",
        "Satisfaction guaranteed"
    ],
    "trust_elements": [
        {"icon": "Shield", "text": "Secure checkout"},
        {"icon": "Truck", "text": "Fast delivery"},
        {"icon": "BadgeCheck", "text": "Quality guaranteed"}
    ]
}'::jsonb) ON CONFLICT DO NOTHING;

INSERT INTO customer_reviews (content) VALUES ('{
    "title": "What Our Customers Say",
    "reviews": [
        {
            "name": "Sarah M.",
            "rating": 5,
            "comment": "Amazing variety and quality! My family loves these snacks.",
            "location": "Texas",
            "verified": true
        },
        {
            "name": "Michael R.", 
            "rating": 5,
            "comment": "Perfect for office snacking. Great value for money.",
            "location": "California",
            "verified": true
        },
        {
            "name": "Emma L.",
            "rating": 4,
            "comment": "High quality snacks, fast delivery. Will order again!",
            "location": "Florida", 
            "verified": true
        }
    ]
}'::jsonb) ON CONFLICT DO NOTHING;

INSERT INTO footer (content) VALUES ('{
    "social_links": [
        {"name": "Facebook", "icon": "Facebook", "url": "https://facebook.com"},
        {"name": "Instagram", "icon": "Instagram", "url": "https://instagram.com"},
        {"name": "Twitter", "icon": "Twitter", "url": "https://twitter.com"}
    ]
}'::jsonb) ON CONFLICT DO NOTHING;

INSERT INTO product_gallery (content) VALUES ('{
    "title": "Delicious Snack Variety",
    "images": [
        {
            "url": "https://cdn.builder.io/api/v1/image/assets%2F84282e2d620247d2b8d8845fda2c790e%2F79d471e5bc56457eb2c3b1c3eb6586ae?format=webp&width=800",
            "alt": "Nutritious Snack Box",
            "title": "Complete Snack Collection"
        },
        {
            "url": "https://cdn.builder.io/api/v1/image/assets%2F79b7dfd5cb0f4ca0b96e836c27c6ef40%2F4d9abe9f679440fcb3470285697707f4?format=webp&width=800", 
            "alt": "Breakfast Bars",
            "title": "Healthy Breakfast Options"
        },
        {
            "url": "https://cdn.builder.io/api/v1/image/assets%2F79b7dfd5cb0f4ca0b96e836c27c6ef40%2F6305c43f8b6449fc8926c50b002e25fe?format=webp&width=800",
            "alt": "Premium Packaging", 
            "title": "Professional Presentation"
        }
    ]
}'::jsonb) ON CONFLICT DO NOTHING;

INSERT INTO trust_section (content) VALUES ('{
    "walmart_info": {
        "text": "Sold on Walmart",
        "subtext": "Trusted marketplace with secure checkout"
    },
    "seller_info": {
        "name": "Gift-A-Snack",
        "rating": 4.6,
        "reviews_count": 127
    },
    "guarantee": {
        "text": "30-Day Returns", 
        "subtext": "Easy returns & exchanges"
    }
}'::jsonb) ON CONFLICT DO NOTHING;

-- Create storage bucket for images (if it doesn't exist)
INSERT INTO storage.buckets (id, name, public) 
VALUES ('images', 'images', true) 
ON CONFLICT (id) DO NOTHING;

-- Set up storage policies for public read access
CREATE POLICY "Public read access" ON storage.objects FOR SELECT USING (bucket_id = 'images');
CREATE POLICY "Authenticated upload access" ON storage.objects FOR INSERT WITH CHECK (bucket_id = 'images' AND auth.role() = 'authenticated');
CREATE POLICY "Authenticated update access" ON storage.objects FOR UPDATE USING (bucket_id = 'images' AND auth.role() = 'authenticated');
CREATE POLICY "Authenticated delete access" ON storage.objects FOR DELETE USING (bucket_id = 'images' AND auth.role() = 'authenticated');
