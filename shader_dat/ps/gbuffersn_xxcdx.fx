float4 g_All_Offset : register(c46);
float4 g_BlurParam : register(c184);
float4 g_ColorEnhance : register(c48);
sampler g_Color_1_sampler : register(s0);
samplerCUBE g_CubeSampler : register(s3);
float4 g_GroundHemisphereColor : register(c190);
sampler g_Normalmap_sampler : register(s4);
sampler g_OcclusionSampler : register(s2);
float4 g_SkyHemisphereColor : register(c189);
float4 g_ambientRate : register(c191);
float4 g_cubeParam : register(c42);
float4 g_cubeParam2 : register(c47);
float3 g_lightDir : register(c45);
float4 g_normalmapRate : register(c43);
float4 g_otherParam : register(c44);
float4 g_specParam : register(c41);

struct PS_IN
{
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float3 texcoord5 : TEXCOORD5;
	float3 texcoord6 : TEXCOORD6;
	float4 texcoord7 : TEXCOORD7;
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
	float3 r5;
	float3 r6;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(g_Color_1_sampler, r0);
	r1 = r0.w + -g_otherParam.y;
	clip(r1);
	r1.xyz = r0.xyz * g_ColorEnhance.xyz;
	r2 = tex2D(g_OcclusionSampler, i.texcoord.zwzw);
	o.color.xyz = r1.xyz * r2.www;
	r1.xyz = r1.xyz * r2.xxx;
	r3 = tex2D(g_Normalmap_sampler, i.texcoord8.zwzw);
	r3.xy = r3.yw * 2 + -1;
	r4.x = r3.y * i.texcoord2.w;
	r4.y = -r3.x;
	r1.w = dot(r4.w, r4.w) + 0;
	r1.w = -r1.w + 1;
	r1.w = 1 / sqrt(r1.w);
	r4.z = 1 / r1.w;
	r3.xyz = r4.xyz * g_normalmapRate.xxx;
	r4.xyz = normalize(i.texcoord2.xyz);
	r5.xyz = normalize(i.texcoord3.xyz);
	r6.xyz = r4.zxy * r5.yzx;
	r6.xyz = r4.yzx * r5.zxy + -r6.xyz;
	r6.xyz = r3.yyy * r6.xyz;
	r4.xyz = r3.xxx * r4.xyz + r6.xyz;
	r4.xyz = r3.zzz * r5.xyz + r4.xyz;
	r1.w = dot(g_lightDir.xyz, r5.xyz);
	r5.xyz = normalize(r4.xyz);
	o.color1.xyz = r5.xyz * 0.5 + 0.5;
	r4.x = g_otherParam.x;
	o.color1.w = r4.x + g_specParam.y;
	r2.w = 1 / i.texcoord7.z;
	r4.xy = r2.ww * i.texcoord8.xy;
	r2.w = 1 / i.texcoord7.w;
	r4.xy = i.texcoord7.xy * r2.ww + -r4.xy;
	r2.w = 0.5;
	o.color3.xy = r4.xy * g_BlurParam.xy + r2.ww;
	r2.z = r2.z * r2.z + -r0.w;
	r2.z = g_specParam.w * r2.z + r0.w;
	r2.z = r2.z * g_specParam.x;
	o.color3.z = r2.z * 1.000001;
	r4.xyz = i.texcoord4.xyz;
	r6.xyz = r4.zxy * i.texcoord5.yzx;
	r4.xyz = r4.yzx * i.texcoord5.zxy + -r6.xyz;
	r4.xyz = r3.yyy * r4.xyz;
	r3.xyw = r3.xxx * i.texcoord4.xyz + r4.xyz;
	r3.xyz = r3.zzz * i.texcoord5.xyz + r3.xyw;
	r2.z = dot(i.texcoord6.xyz, r3.xyz);
	r2.z = r2.z + r2.z;
	r3.xyz = r3.xyz * -r2.zzz + i.texcoord6.xyz;
	r3.w = -r3.z;
	r3 = tex2D(g_CubeSampler, r3.xyww);
	r4.xyz = normalize(-i.texcoord1.xyz);
	r2.z = dot(r4.xyz, r5.xyz);
	r2.w = dot(g_lightDir.xyz, r5.xyz);
	r1.w = -r1.w + r2.w;
	r2.w = 1;
	r1.w = r1.w * g_normalmapRate.x + r2.w;
	r1.xyz = r1.www * r1.xyz;
	r1.w = pow(r2.z, g_otherParam.w);
	r2.z = r1.w + 0.2;
	r1.w = -r1.w + 0.01;
	r2.z = 1 / r2.z;
	r1.w = (r1.w >= 0) ? 4.7619047 : r2.z;
	r0.w = g_cubeParam.z * r0.w + g_cubeParam.x;
	r2.z = g_cubeParam2.z;
	r0.xyz = r0.xyz * g_ColorEnhance.xyz + r2.zzz;
	r0.w = g_cubeParam.w * r2.y + r0.w;
	r2.yzw = r0.www * r3.xyz;
	r2.yzw = r2.yzw * g_cubeParam.yyy;
	r3.xyz = r2.yzw * r1.www + -r2.yzw;
	r2.yzw = r3.www * r3.xyz + r2.yzw;
	r3.xyz = r3.www * r2.yzw;
	r3.xyz = r3.xyz * g_cubeParam2.yyy;
	r2.yzw = r2.yzw * g_cubeParam2.xxx + r3.xyz;
	r0.xyz = r0.xyz * r2.yzw;
	r0.w = r2.x * 0.5 + 0.5;
	r1.w = r2.x * r2.x;
	o.color.w = r1.w;
	r0.w = r0.w * r0.w;
	r0.xyz = r0.www * r0.xyz;
	r0.w = 0.1 + -i.texcoord3.w;
	r2.xyz = r0.www * g_GroundHemisphereColor.xyz;
	r0.w = 0.1 + i.texcoord3.w;
	r2.xyz = g_SkyHemisphereColor.xyz * r0.www + r2.xyz;
	r2.xyz = r2.xyz + g_ambientRate.xyz;
	o.color2.xyz = r2.xyz * r1.xyz + r0.xyz;
	o.color2.w = g_otherParam.z;
	o.color3.w = g_specParam.z;

	return o;
}
