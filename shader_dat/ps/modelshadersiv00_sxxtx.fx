sampler Color_1_sampler : register(s0);
sampler Shadow_Tex_sampler : register(s11);
sampler Spec_Pow_sampler : register(s6);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float4 light_Color : register(c61);
float4 lightpos : register(c62);
float4 prefogcolor_enhance : register(c77);
float4 specularParam : register(c41);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float3 r2;
	float3 r3;
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(Shadow_Tex_sampler, r0);
	r0.x = r0.z + g_ShadowUse.x;
	r0.y = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.y = 1 / sqrt(r0.y);
	r0.yzw = -i.texcoord1.xyz * r0.yyy + lightpos.xyz;
	r1.xyz = normalize(r0.yzw);
	r0.y = dot(r1.xyz, i.texcoord3.xyz);
	r0.z = -r0.y + 1;
	r1.x = r0.z * -specularParam.z + r0.y;
	r1.y = specularParam.y;
	r1 = tex2D(Spec_Pow_sampler, r1);
	r0.yzw = r1.xyz * light_Color.xyz;
	r1.xy = g_All_Offset.xy + i.texcoord.xy;
	r1 = tex2D(Color_1_sampler, r1);
	r0.yzw = r0.yzw * r1.www;
	r0.yzw = r0.xxx * r0.yzw;
	r2.xyz = ambient_rate.xyz;
	r2.xyz = r0.xxx * ambient_rate_rate.xyz + r2.xyz;
	r2.xyz = r2.xyz + i.texcoord2.xyz;
	r0.x = abs(specularParam.x);
	r0.xyz = r0.xxx * r0.yzw;
	r3.xy = -r1.yy + r1.xz;
	r0.w = max(abs(r3.x), abs(r3.y));
	r0.w = r0.w + -0.015625;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r1.xz = (r0.ww >= 0) ? r1.yy : r1.xz;
	r0.w = 1 / ambient_rate.w;
	r3.xyz = r1.xyz * r0.www + specularParam.www;
	r1.xyz = r0.www * r1.xyz;
	r0.xyz = r0.xyz * r3.xyz;
	r0.xyz = r1.xyz * r2.xyz + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
