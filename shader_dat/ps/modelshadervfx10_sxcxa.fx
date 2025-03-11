sampler Color_1_sampler : register(s0);
float4 CubeParam : register(c42);
sampler RefractMap_sampler : register(s12);
float4 Refract_Param : register(c43);
float4 SoftPt_Rate : register(c44);
float4 ambient_rate : register(c40);
samplerCUBE cubemap_sampler : register(s1);
float4 finalcolor_enhance : register(c78);
float3 fog : register(c67);
float4 g_TargetUvParam : register(c194);
float4 prefogcolor_enhance : register(c77);

struct PS_IN
{
	float4 color : COLOR;
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float2 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord8 : TEXCOORD8;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
	float3 r4;
	r0 = tex2D(Color_1_sampler, i.texcoord);
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
	r1.x = 1 / i.texcoord8.w;
	r1.xy = r1.xx * i.texcoord8.xy;
	r1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + g_TargetUvParam.xy;
	r1.xy = i.texcoord3.xy * -Refract_Param.yy + r1.xy;
	r1 = tex2D(RefractMap_sampler, r1);
	r2.w = r0.w * ambient_rate.w;
	r3.xyz = lerp(r1.xyz, r0.xyz, Refract_Param.xxx);
	r0.xyz = r3.xyz * ambient_rate.xyz;
	r1 = tex2D(cubemap_sampler, i.texcoord4);
	r0.w = r1.w * CubeParam.y + CubeParam.x;
	r1.xyz = r0.www * r1.xyz;
	r3.xyz = r3.xyz * r1.xyz;
	r4.xyz = r3.xyz * CubeParam.zzz + r0.xyz;
	r3.xyz = r3.xyz * CubeParam.zzz;
	r0.xyz = r0.xyz * -r3.xyz + r4.xyz;
	r3.y = 1;
	r0.w = r3.y + -CubeParam.z;
	r2.xyz = r1.xyz * r0.www + r0.xyz;
	r0 = -1 + i.color;
	r0 = SoftPt_Rate.y * r0 + r3.y;
	r0 = r0 * r2;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	r1.w = r0.w * prefogcolor_enhance.w;
	r1.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o = r1 * finalcolor_enhance;

	return o;
}
