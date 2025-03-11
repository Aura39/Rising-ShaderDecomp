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
	float4 r2;
	float3 r3;
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(Shadow_Tex_sampler, r0);
	r0.x = r0.z + g_ShadowUse.x;
	r0.y = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.yzw = r0.yyy * light_Color.xyz;
	r0.yzw = r0.yzw * r0.xxx + i.texcoord2.xyz;
	r1.xy = g_All_Offset.xy + i.texcoord.xy;
	r1 = tex2D(Color_1_sampler, r1);
	r2.xy = -r1.yy + r1.xz;
	r3.x = max(abs(r2.x), abs(r2.y));
	r2.x = r3.x + -0.015625;
	r2.y = (-r2.x >= 0) ? 0 : 1;
	r2.x = (r2.x >= 0) ? -0 : -1;
	r2.x = r2.x + r2.y;
	r2.x = (r2.x >= 0) ? -r2.x : -0;
	r1.xz = (r2.xx >= 0) ? r1.yy : r1.xz;
	r0.yzw = r0.yzw * r1.xyz;
	r2.xyz = r1.xyz * ambient_rate.xyz;
	r1.xyz = r1.xyz + specularParam.www;
	r0.yzw = r2.xyz * ambient_rate_rate.xyz + r0.yzw;
	r2.x = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r2.x = 1 / sqrt(r2.x);
	r2.xyz = -i.texcoord1.xyz * r2.xxx + lightpos.xyz;
	r3.xyz = normalize(r2.xyz);
	r2.x = dot(r3.xyz, i.texcoord3.xyz);
	r2.y = -r2.x + 1;
	r2.x = r2.y * -specularParam.z + r2.x;
	r2.y = specularParam.y;
	r2 = tex2D(Spec_Pow_sampler, r2);
	r2.xyz = r2.xyz * light_Color.xyz;
	r2.xyz = r1.www * r2.xyz;
	r2.xyz = r0.xxx * r2.xyz;
	r0.x = abs(specularParam.x);
	r2.xyz = r0.xxx * r2.xyz;
	r0.xyz = r2.xyz * r1.xyz + r0.yzw;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
