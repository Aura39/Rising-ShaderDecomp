sampler Color_1_sampler : register(s0);
float4 CubeParam : register(c42);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
samplerCUBE cubemap2_sampler : register(s9);
samplerCUBE cubemap_sampler : register(s2);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float g_CubeBlendParam : register(c175);
float4 g_eyeLightDir : register(c187);
float4 g_eyeLightDir2 : register(c188);
float4 light_Color : register(c61);
float4 prefogcolor_enhance : register(c77);
float4 specularParam : register(c41);
float4 tile : register(c45);
sampler tripleMask_sampler : register(s1);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float3 r5;
	r0.xyz = normalize(-g_eyeLightDir2.xyz);
	r1.xyz = normalize(i.texcoord3.xyz);
	r0.x = dot(r0.xyz, r1.xyz);
	r1.w = pow(r0.x, specularParam.z);
	r0.x = r1.w * g_eyeLightDir2.w;
	r2.xyz = normalize(-g_eyeLightDir.xyz);
	r0.y = dot(r2.xyz, r1.xyz);
	r1.x = pow(r0.y, specularParam.z);
	r0.x = r1.x * g_eyeLightDir.w + r0.x;
	r0.xyz = r0.xxx * light_Color.xyz;
	r1.xy = tile.xy * i.texcoord.xy;
	r1 = tex2D(tripleMask_sampler, r1);
	r0.xyz = r0.xyz * r1.zzz;
	r0.w = abs(specularParam.x);
	r0.xyz = r0.www * r0.xyz;
	r2 = tex2D(cubemap_sampler, i.texcoord4);
	r3 = tex2D(cubemap2_sampler, i.texcoord4);
	r4 = lerp(r3, r2, g_CubeBlendParam.x);
	r2 = r4 * ambient_rate_rate.w;
	r1.yzw = r1.yyy * r2.xyz;
	r0.w = r2.w * CubeParam.y + CubeParam.x;
	r1.yzw = r0.www * r1.yzw;
	r2.xy = g_All_Offset.xy + i.texcoord.xy;
	r3 = tex2D(Color_1_sampler, r2);
	r2.xy = -r3.yy + r3.xz;
	r0.w = max(abs(r2.x), abs(r2.y));
	r0.w = r0.w + -0.015625;
	r2.x = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r2.x;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r3.xz = (r0.ww >= 0) ? r3.yy : r3.xz;
	r0.w = r3.w * ambient_rate.w;
	r2.xyz = r1.yzw * r3.xyz;
	r4.xyz = r1.xxx * r3.xyz;
	r3.xyz = r3.xyz + specularParam.www;
	r4.xyz = r4.xyz * ambient_rate.xyz;
	r4.xyz = r4.xyz * ambient_rate_rate.xyz;
	r5.xyz = r2.xyz * CubeParam.zzz + r4.xyz;
	r2.xyz = r2.xyz * CubeParam.zzz;
	r2.xyz = r4.xyz * -r2.xyz + r5.xyz;
	r2.xyz = r0.xyz * r3.xyz + r2.xyz;
	r0.xyz = r0.xyz * r3.xyz;
	r3.z = CubeParam.z;
	r1.x = -r3.z + 1;
	r1.xyz = r1.yzw * r1.xxx + r2.xyz;
	r2.xyz = fog.xyz;
	r1.xyz = r1.xyz * prefogcolor_enhance.xyz + -r2.xyz;
	o.xyz = i.texcoord1.www * r1.xyz + fog.xyz;
	r1.x = max(r0.x, r0.y);
	r2.x = max(r1.x, r0.z);
	r0.x = r2.x * specularParam.x;
	r0.y = max(CubeParam.x, CubeParam.y);
	r0.x = r2.w * r0.y + r0.x;
	r1.x = max(r0.x, r0.w);
	r0.x = r1.x * prefogcolor_enhance.w;
	o.w = r0.x;

	return o;
}
