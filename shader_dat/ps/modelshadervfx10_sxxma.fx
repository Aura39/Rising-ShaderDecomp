sampler Color_1_sampler;
sampler RefractMap_sampler;
float4 Refract_Param;
float4 SoftPt_Rate;
float4 ambient_rate;
float4 finalcolor_enhance;
float3 fog;
float4 g_TargetUvParam;
sampler nkiMask_sampler;
float4 nkiTile;
float4 prefogcolor_enhance;

struct PS_IN
{
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float2 texcoord3 : TEXCOORD3;
	float4 texcoord8 : TEXCOORD8;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
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
	r1.w = 1 / i.texcoord8.w;
	r2.xy = r1.ww * i.texcoord8.xy;
	r2.xy = r2.xy * float2(0.5, -0.5) + 0.5;
	r2.xy = r2.xy + g_TargetUvParam.xy;
	r2.xy = i.texcoord3.xy * -Refract_Param.yy + r2.xy;
	r2 = tex2D(RefractMap_sampler, r2);
	r3.xyz = lerp(r2.xyz, r1.xyz, Refract_Param.xxx);
	r0.xyz = r3.xyz * ambient_rate.xyz;
	r1 = -1 + i.color;
	r2.y = 1;
	r1 = SoftPt_Rate.y * r1 + r2.y;
	r0 = r0 * r1;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	r1.w = r0.w * prefogcolor_enhance.w;
	r1.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o = r1 * finalcolor_enhance;

	return o;
}
