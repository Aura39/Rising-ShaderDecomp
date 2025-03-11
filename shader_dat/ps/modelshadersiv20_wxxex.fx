sampler Color_1_sampler : register(s0);
float4 CubeParam : register(c42);
sampler Shadow_Tex_sampler : register(s11);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float4 light_Color : register(c61);
float4 lightpos : register(c62);
sampler normalmap_sampler : register(s4);
float4 prefogcolor_enhance : register(c77);
float4 specularParam : register(c41);
float4 tile : register(c43);

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
	r0.y = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.y = 1 / sqrt(r0.y);
	r0.yzw = -i.texcoord1.xyz * r0.yyy + lightpos.xyz;
	r1.xyz = normalize(r0.yzw);
	r0.y = dot(r1.xyz, i.texcoord3.xyz);
	r1.x = pow(r0.y, specularParam.z);
	r0.z = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.w = (-r0.z >= 0) ? 0 : 1;
	r0.y = (-r0.y >= 0) ? 0 : r0.w;
	r0.w = r0.z * r0.w;
	r1.yzw = r0.zzz * light_Color.xyz;
	r1.yzw = r1.yzw * r0.xxx + i.texcoord2.xyz;
	r2.xyz = r0.www * light_Color.xyz;
	r0.y = r1.x * r0.y;
	r0.yzw = r0.yyy * r2.xyz;
	r2.xy = g_All_Offset.xy + i.texcoord.xy;
	r2 = tex2D(Color_1_sampler, r2);
	r0.yzw = r0.yzw * r2.www;
	r0.xyz = r0.xxx * r0.yzw;
	r0.w = abs(specularParam.x);
	r0.xyz = r0.www * r0.xyz;
	r3.xy = -r2.yy + r2.xz;
	r0.w = max(abs(r3.x), abs(r3.y));
	r0.w = r0.w + -0.015625;
	r1.x = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.x;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r2.xz = (r0.ww >= 0) ? r2.yy : r2.xz;
	r1.xyz = r1.yzw * r2.xyz;
	r3.xyz = r2.xyz * ambient_rate.xyz;
	r2.xyz = r2.xyz + specularParam.www;
	r1.xyz = r3.xyz * ambient_rate_rate.xyz + r1.xyz;
	r0.xyz = r0.xyz * r2.xyz + r1.xyz;
	r1.xy = tile.xy * i.texcoord.xy;
	r1 = tex2D(normalmap_sampler, r1);
	r1.xyz = r1.xyz + -1;
	r0.w = abs(CubeParam.w);
	r1.xyz = r0.www * r1.xyz + 1;
	r0.xyz = r0.xyz * r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
