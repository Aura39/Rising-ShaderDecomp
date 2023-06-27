float4 g_All_Offset;
float4 g_ColorEnhance;
sampler g_Color_1_sampler;
sampler g_Color_2_sampler;
samplerCUBE g_CubeSampler;
float4 g_GroundHemisphereColor;
sampler g_Normalmap_sampler;
float4 g_SkyHemisphereColor;
float4 g_ambientRate;
float4 g_cubeParam;
float4 g_cubeParam2;
float4 g_lightColor;
float3 g_lightDir;
float4 g_normalmapRate;
float4 g_olcParam;
float4 g_otherParam;
float4 g_specParam;

struct PS_IN
{
	float4 color : COLOR;
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord8 : TEXCOORD8;
};

struct PS_OUT
{
	float4 color1 : COLOR1;
	float4 color3 : COLOR3;
	float4 color : COLOR;
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
	r1.xyz = normalize(i.texcoord3.xyz);
	o.color1.xyz = r1.xyz * 0.5 + 0.5;
	r1.w = -g_specParam.x;
	r1.w = (-r1.w >= 0) ? 0 : 0.25;
	r2.x = g_otherParam.x;
	r2.x = r2.x + g_specParam.y;
	o.color1.w = r1.w + r2.x;
	r1.w = dot(r0.www, 0.298912);
	r2.x = abs(g_specParam.x);
	o.color3.z = r1.w * r2.x;
	r2.xyz = normalize(-i.texcoord1.xyz);
	r1.w = dot(r2.xyz, r1.xyz);
	r1.x = dot(g_lightDir.xyz, r1.xyz);
	r1.x = r1.x + 0.5;
	r1.yz = float2(-1, 1);
	r1.w = r1.w * g_olcParam.w + r1.z;
	r2.x = frac(r1.w);
	r1.w = r1.w + -r2.x;
	r1.z = r1.z + g_olcParam.y;
	r2.x = frac(r1.z);
	r1.z = r1.z + -r2.x;
	r1.z = 1 / r1.z;
	r1.z = r1.w * -r1.z + 1;
	r1.z = r1.z * g_olcParam.z;
	r1.w = frac(r1.x);
	r1.x = -r1.w + r1.x;
	r1.w = -r1.x + 1;
	r1.x = r1.x + g_olcParam.x;
	r1.z = r1.w * r1.z;
	r0.w = g_cubeParam.z * r0.w + g_cubeParam.x;
	r2 = tex2D(g_CubeSampler, i.texcoord4);
	r3.xy = g_All_Offset.zw * i.texcoord.xy;
	r3 = tex2D(g_Color_2_sampler, r3);
	r1.w = r3.w * -i.color.w + 1;
	r2 = r1.w * r2;
	r2.xyz = r0.www * r2.xyz;
	r2.xyz = r2.xyz * g_cubeParam.yyy;
	r4.xyz = r2.www * r2.xyz;
	r4.xyz = r4.xyz * g_cubeParam2.yyy;
	r2.xyz = r2.xyz * g_cubeParam2.xxx + r4.xyz;
	r0.w = r3.w * i.color.w;
	r4.xyz = lerp(r3.xyz, r0.xyz, r0.www);
	r0 = tex2D(g_Normalmap_sampler, i.texcoord8.zwzw);
	r0.xyz = r0.xyz + -1;
	r0.w = abs(g_normalmapRate.x);
	r0.xyz = r0.www * r0.xyz + 1;
	r0.xyz = r0.xyz * r4.xyz;
	r3.xyz = g_ColorEnhance.xyz * i.color.xyz;
	r4.xyz = r0.xyz * r3.xyz + g_cubeParam2.zzz;
	r0.xyz = r0.xyz * r3.xyz;
	r2.xyz = r2.xyz * r4.xyz;
	r0.w = 0.1 + -i.texcoord3.w;
	r3.xyz = r0.www * g_GroundHemisphereColor.xyz;
	r0.w = 0.1 + i.texcoord3.w;
	r3.xyz = g_SkyHemisphereColor.xyz * r0.www + r3.xyz;
	r3.xyz = r3.xyz + g_ambientRate.xyz;
	r3.xyz = r0.xyz * r3.xyz;
	r2.xyz = r3.xyz * r1.xxx + r2.xyz;
	r3.xyz = r0.xyz * g_lightColor.xyz;
	o.color.xyz = r0.xyz;
	o.color2.xyz = r3.xyz * r1.zzz + r2.xyz;
	o.color.w = 1;
	o.color2.w = g_otherParam.z;
	o.color3.x = r1.y + -g_ambientRate.w;
	o.color3.y = g_cubeParam2.w;
	o.color3.w = g_specParam.z;

	return o;
}
