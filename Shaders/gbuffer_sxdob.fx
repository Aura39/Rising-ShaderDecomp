float4 g_All_Offset;
float4 g_ColorEnhance;
sampler g_Color_1_sampler;
sampler g_Color_2_sampler;
samplerCUBE g_CubeSampler;
float4 g_GroundHemisphereColor;
sampler g_MaskSampler;
sampler g_OcclusionSampler;
float4 g_SkyHemisphereColor;
float4 g_ambientRate;
float4 g_cubeParam;
float4 g_cubeParam2;
float4 g_lightColor;
float3 g_lightDir;
float4 g_olcParam;
float4 g_otherParam;

struct PS_IN
{
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord8 : TEXCOORD8;
};

struct PS_OUT
{
	float4 color : COLOR;
	float4 color1 : COLOR1;
	float4 color2 : COLOR2;
	float4 color3 : COLOR3;
};

PS_OUT main(PS_IN i)
{
	PS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
	float4 r4;
	float4 r5;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(g_Color_1_sampler, r0);
	r1 = r0.w + -g_otherParam.y;
	clip(r1);
	r1.xy = g_All_Offset.zw * i.texcoord.xy;
	r1 = tex2D(g_Color_2_sampler, r1);
	r0.w = r1.w * i.color.w;
	r2.xyz = lerp(r1.xyz, r0.xyz, r0.www);
	r0.x = r1.w * -i.color.w + 1;
	r0.yzw = g_ColorEnhance.xyz * i.color.xyz;
	r1.xyz = r0.yzw * r2.xyz;
	r0.yzw = r2.xyz * r0.yzw + g_cubeParam2.zzz;
	r2 = tex2D(g_OcclusionSampler, i.texcoord.zwzw);
	r3.xyz = -r2.xyw + 1;
	r2.xyz = g_ambientRate.www * r3.xyz + r2.xyw;
	o.color.xyz = r1.xyz * r2.zzz;
	r3.xyz = normalize(i.texcoord3.xyz);
	o.color1.xyz = r3.xyz * 0.5 + 0.5;
	r4 = tex2D(g_CubeSampler, i.texcoord4);
	r4 = r0.x * r4;
	r5 = tex2D(g_MaskSampler, i.texcoord8.zwzw);
	r5.xyz = g_cubeParam.zzz * r5.xyz + g_cubeParam.xxx;
	r2.yzw = g_cubeParam.www * r2.yyy + r5.xyz;
	r2.yzw = r2.yzw * r4.xyz;
	r2.yzw = r2.yzw * g_cubeParam.yyy;
	r4.xyz = r4.www * r2.yzw;
	r4.xyz = r4.xyz * g_cubeParam2.yyy;
	r2.yzw = r2.yzw * g_cubeParam2.xxx + r4.xyz;
	r0.xyz = r0.yzw * r2.yzw;
	r0.w = r2.x * 0.5 + 0.5;
	r0.w = r0.w * r0.w;
	r0.xyz = r0.www * r0.xyz;
	r2.yzw = r1.xyz * r2.xxx;
	r1.xyz = r1.xyz * g_lightColor.xyz;
	o.color.w = r2.x;
	r0.w = 0.1 + -i.texcoord3.w;
	r4.xyz = r0.www * g_GroundHemisphereColor.xyz;
	r0.w = 0.1 + i.texcoord3.w;
	r4.xyz = g_SkyHemisphereColor.xyz * r0.www + r4.xyz;
	r4.xyz = r4.xyz + g_ambientRate.xyz;
	r2.xyz = r2.yzw * r4.xyz;
	r0.w = dot(g_lightDir.xyz, r3.xyz);
	r0.w = r0.w + 0.5;
	r1.w = frac(r0.w);
	r0.w = r0.w + -r1.w;
	r1.w = r0.w + g_olcParam.x;
	r0.w = -r0.w + 1;
	r0.xyz = r2.xyz * r1.www + r0.xyz;
	r2.xyz = normalize(-i.texcoord1.xyz);
	r1.w = dot(r2.xyz, r3.xyz);
	r2.y = 0.5;
	r1.w = r1.w * g_olcParam.w + r2.y;
	r2.x = frac(r1.w);
	r1.w = r1.w + -r2.x;
	r2.x = r2.y + g_olcParam.y;
	r2.y = frac(r2.x);
	r2.x = -r2.y + r2.x;
	r2.x = 1 / r2.x;
	r1.w = r1.w * -r2.x + 1;
	r1.w = r1.w * g_olcParam.z;
	r0.w = r0.w * r1.w;
	o.color2.xyz = r1.xyz * r0.www + r0.xyz;
	o.color1.w = g_otherParam.x;
	o.color2.w = g_otherParam.z;
	r0.w = g_ambientRate.w;
	o.color3.xzw = r0.www * float3(-1, 0, 0) + float3(1, 0, 0);
	o.color3.y = g_cubeParam2.w;

	return o;
}
