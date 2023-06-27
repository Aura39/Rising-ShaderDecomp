float4 g_All_Offset;
float4 g_ColorEnhance;
sampler g_Color_1_sampler;
float4 g_GroundHemisphereColor;
sampler g_MaskSampler;
sampler g_Normalmap_sampler;
sampler g_OcclusionSampler;
float4 g_SkyHemisphereColor;
float4 g_ambientRate;
float4 g_cubeParam2;
float4 g_lightColor;
float3 g_lightDir;
float4 g_normalmapRate;
float4 g_olcParam;
float4 g_otherParam;
float4 g_specParam;

struct PS_IN
{
	float3 color : COLOR;
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord3 : TEXCOORD3;
	float4 texcoord8 : TEXCOORD8;
};

struct PS_OUT
{
	float4 color : COLOR;
	float4 color1 : COLOR1;
	float4 color3 : COLOR3;
	float4 color2 : COLOR2;
};

PS_OUT main(PS_IN i)
{
	PS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float3 r4;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(g_Color_1_sampler, r0);
	r1 = r0.w + -g_otherParam.y;
	clip(r1);
	r1 = tex2D(g_Normalmap_sampler, i.texcoord8.zwzw);
	r1.xyz = r1.xyz + -1;
	r0.w = abs(g_normalmapRate.x);
	r1.xyz = r0.www * r1.xyz + 1;
	r0.xyz = r0.xyz * r1.xyz;
	r1.xyz = g_ColorEnhance.xyz * i.color.xyz;
	r0.xyz = r0.xyz * r1.xyz;
	r1 = tex2D(g_OcclusionSampler, i.texcoord.zwzw);
	r2.xyz = -r1.xzw + 1;
	r1.xyz = g_ambientRate.www * r2.xyz + r1.xzw;
	o.color.xyz = r0.xyz * r1.zzz;
	r2.xyz = normalize(i.texcoord3.xyz);
	o.color1.xyz = r2.xyz * 0.5 + 0.5;
	r0.w = -g_specParam.x;
	r0.w = (-r0.w >= 0) ? 0 : 0.25;
	r3.y = g_specParam.y;
	r1.z = r3.y + g_otherParam.x;
	o.color1.w = r0.w + r1.z;
	r3 = tex2D(g_MaskSampler, i.texcoord8.zwzw);
	r4.xyz = lerp(r1.yyy, r3.xyz, g_specParam.www);
	r0.w = dot(r4.xyz, 0.298912);
	r1.y = abs(g_specParam.x);
	o.color3.z = r0.w * r1.y;
	r3.xyz = normalize(-i.texcoord1.xyz);
	r0.w = dot(r3.xyz, r2.xyz);
	r1.y = dot(g_lightDir.xyz, r2.xyz);
	r1.y = r1.y + 0.5;
	r2.xz = float2(1, -1);
	r0.w = r0.w * g_olcParam.w + r2.z;
	r1.z = frac(r0.w);
	r0.w = r0.w + -r1.z;
	r1.z = r2.z + g_olcParam.y;
	r1.w = frac(r1.z);
	r1.z = -r1.w + r1.z;
	r1.z = 1 / r1.z;
	r0.w = r0.w * -r1.z + 1;
	r0.w = r0.w * g_olcParam.z;
	r1.z = frac(r1.y);
	r1.y = -r1.z + r1.y;
	r1.z = -r1.y + 1;
	r1.y = r1.y + g_olcParam.x;
	r0.w = r0.w * r1.z;
	r2.yzw = r0.xyz * g_lightColor.xyz;
	r0.xyz = r0.xyz * r1.xxx;
	o.color.w = r1.x;
	r1.xzw = r0.www * r2.yzw;
	r0.w = 0.1 + -i.texcoord3.w;
	r2.yzw = r0.www * g_GroundHemisphereColor.xyz;
	r0.w = 0.1 + i.texcoord3.w;
	r2.yzw = g_SkyHemisphereColor.xyz * r0.www + r2.yzw;
	r2.yzw = r2.yzw + g_ambientRate.xyz;
	r0.xyz = r0.xyz * r2.yzw;
	o.color2.xyz = r0.xyz * r1.yyy + r1.xzw;
	o.color2.w = g_otherParam.z;
	o.color3.x = r2.x + -g_ambientRate.w;
	o.color3.y = g_cubeParam2.w;
	o.color3.w = g_specParam.z;

	return o;
}
