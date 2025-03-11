float4 g_CommonParam : register(c185);
float4 g_MatrialColor : register(c184);
sampler g_Sampler0 : register(s0);
sampler g_SamplerBg : register(s12);
float4 g_TargetUvParam : register(c194);
float4 g_UvParam0 : register(c186);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float3 r1;
	float3 r2;
	float3 r3;
	r0.x = -0.01;
	r0 = r0.x + g_MatrialColor.w;
	clip(r0);
	r0.xy = i.texcoord.xy * g_UvParam0.xy + g_UvParam0.zw;
	r0 = tex2D(g_Sampler0, r0);
	r0.xyz = r0.xyz * 2 + -1;
	r1.x = r0.x * i.texcoord2.w;
	r1.yz = r0.yz * float2(-0.01, -1);
	r0.xyz = normalize(r1.xyz);
	r1.xyz = normalize(i.texcoord2.xyz);
	r2.xyz = normalize(i.texcoord1.xyz);
	r3.xyz = r1.zxy * r2.yzx;
	r3.xyz = r1.yzx * r2.zxy + -r3.xyz;
	r3.xyz = r0.yyy * r3.xyz;
	r0.xyw = r0.xxx * r1.xyz + r3.xyz;
	r0.xyz = r0.zzz * r2.xyz + r0.xyw;
	r0.z = dot(r0.xyz, r0.xyz);
	r0.z = 1 / sqrt(r0.z);
	r0.xy = r0.xy * r0.zz + -r2.xy;
	r0.xy = g_CommonParam.ww * r0.xy + r2.xy;
	r0.z = 1 / i.texcoord3.w;
	r0.zw = r0.zz * i.texcoord3.xy;
	r0.zw = r0.zw * float2(0.5, -0.5) + 0.5;
	r0.zw = r0.zw + g_TargetUvParam.xy;
	r0.xy = r0.xy * -g_CommonParam.zz + r0.zw;
	r0 = tex2D(g_SamplerBg, r0);
	o.xyz = r0.xyz * g_MatrialColor.xyz;
	o.w = g_MatrialColor.w;

	return o;
}
