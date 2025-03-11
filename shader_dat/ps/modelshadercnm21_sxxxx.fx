sampler Color_1_sampler : register(s0);
float4 ambient_rate : register(c40);
float4 g_All_Offset : register(c76);
float4 prefogcolor_enhance : register(c77);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord8 : TEXCOORD8;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.x = 1 / i.texcoord8.w;
	r0.xy = r0.xx * i.texcoord8.xy;
	r0.xy = r0.xy * i.texcoord.xx + g_All_Offset.xy;
	r0 = tex2D(Color_1_sampler, r0);
	r1.w = ambient_rate.w;
	r1 = r0.w * r1.w + -0.01;
	clip(r1);
	r1.xy = -r0.yy + r0.xz;
	r2.x = max(abs(r1.x), abs(r1.y));
	r1.x = r2.x + -0.015625;
	r1.y = (-r1.x >= 0) ? 0 : 1;
	r1.x = (r1.x >= 0) ? -0 : -1;
	r1.x = r1.x + r1.y;
	r1.x = (r1.x >= 0) ? -r1.x : -0;
	r0.xz = (r1.xx >= 0) ? r0.yy : r0.xz;
	r1.x = 1 / i.texcoord.y;
	r2.w = r0.w * ambient_rate.w;
	r0.xyz = r0.xyz * r1.xxx;
	r2.xyz = r0.xyz * ambient_rate.xyz;
	o = r2 * prefogcolor_enhance;

	return o;
}
