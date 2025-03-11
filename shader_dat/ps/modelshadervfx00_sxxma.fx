sampler Color_1_sampler : register(s0);
float4 SoftPt_Rate : register(c44);
float4 ambient_rate : register(c40);
float3 fog : register(c67);
sampler nkiMask_sampler : register(s3);
float4 nkiTile : register(c46);
float4 prefogcolor_enhance : register(c77);

struct PS_IN
{
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.xy = i.texcoord.zw * nkiTile.xy + nkiTile.zw;
	r0 = tex2D(nkiMask_sampler, r0);
	r1 = tex2D(Color_1_sampler, i.texcoord);
	r0.x = r0.w * r1.w;
	r0.w = ambient_rate.w;
	r2 = r0.x * r0.w + -0.01;
	r0.w = r0.x * ambient_rate.w;
	clip(r2);
	r2.xy = -r1.yy + r1.xz;
	r1.w = max(abs(r2.x), abs(r2.y));
	r1.w = r1.w + -0.015625;
	r2.x = (-r1.w >= 0) ? 0 : 1;
	r1.w = (r1.w >= 0) ? -0 : -1;
	r1.w = r1.w + r2.x;
	r1.w = (r1.w >= 0) ? -r1.w : -0;
	r1.xz = (r1.ww >= 0) ? r1.yy : r1.xz;
	r0.xyz = r1.xyz * ambient_rate.xyz;
	r1 = -1 + i.color;
	r2.z = 1;
	r1 = SoftPt_Rate.y * r1 + r2.z;
	r0 = r0 * r1;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	r0.w = r0.w * prefogcolor_enhance.w;
	o.w = r0.w;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;

	return o;
}
