float4 SoftPt_Rate;
float4 ambient_rate;
float3 fog;
sampler nkiMask_sampler;
float4 nkiTile;
float4 prefogcolor_enhance;

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
	r1 = float4(-0, -0, -0, -1) + i.color;
	r2.zw = float2(-0, -1);
	r1 = SoftPt_Rate.y * r1 + r2.zzzw;
	r0.x = r0.w * r1.w;
	r0.yzw = r1.xyz * ambient_rate.xyz;
	r1.xyz = fog.xyz;
	r0.yzw = r0.yzw * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.yzw + fog.xyz;
	r0.w = ambient_rate.w;
	r1 = r0.x * r0.w + -0.01;
	r0.x = r0.x * ambient_rate.w;
	r0.x = r0.x * prefogcolor_enhance.w;
	o.w = r0.x;
	clip(r1);

	return o;
}
